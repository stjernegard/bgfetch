package main

import (
	"errors"
	"io"
	"net/http"
	"os"
)

type Download struct {
	fileName string
	image    *Image
	err      error
}

func (d *Download) Run() error {
	outputFile := OutputDir + d.fileName
	if _, err := os.Stat(outputFile); err == nil {
		err := os.Remove(outputFile)
		if err != nil {
			return err
		}
	}

	output, err := os.Create(OutputDir + d.fileName)
	if err != nil {
		return err
	}
	defer output.Close()

	response, err := http.Get(d.image.url)
	if err != nil {
		return err
	}
	defer response.Body.Close()

	_, err = io.Copy(output, response.Body)
	if err != nil {
		return err
	}
	return nil
}
