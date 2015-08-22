package main

import (
	"encoding/json"
	"fmt"
	"net/http"
	"os"
	"strconv"
)

const (
	SourceUrl = "https://www.reddit.com/r/EarthPorn/top.json?sort=top&t=month"
	OutputDir = "/Users/dannistjernegard/Pictures/EarthPorn/"
)

func getJson(url string, target interface{}) error {
	response, err := http.Get(url)
	if err != nil {
		return err
	}
	defer response.Body.Close()

	return json.NewDecoder(response.Body).Decode(target)
}

func main() {
	var page Page
	err := getJson(SourceUrl, &page)
	if err != nil {
		fmt.Println("%s", err.Error())
		os.Exit(1)
	}

	images := page.CompressToImages()

	ch := make(chan *Download)
	downloads := []*Download{}

	for i, image := range images {
		go func(image Image, id int) {
			fileExt, err := image.FileExtension()
			download := Download{strconv.Itoa(id), &image, nil}
			if err != nil {
				download.err = err
			} else {
				download.fileName = download.fileName + "." + fileExt
				download.err = download.Run()
			}
			ch <- &download
		}(image, i)
	}

	for {
		select {
		case download := <-ch:
			if download.err != nil {
				fmt.Println("Error in", download.image.url)
			} else {
				fmt.Println("Finished", download.fileName)
			}
			downloads = append(downloads, download)
			if len(downloads) == len(images) {
				return
			}
		}
	}
}
