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
	if !d.image.IsHorizontal() {
		return errors.New("Image is not horizontal")
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