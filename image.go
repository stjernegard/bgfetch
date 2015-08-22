package main

import (
	"net/url"
	"strings"
)

type Image struct {
	id     string
	url    string
	width  int
	height int
}

func (i *Image) IsHorizontal() bool {
	return i.width > i.height
}

func (i *Image) FileExtension() (string, error) {
	url, err := url.Parse(i.url)
	if err != nil {
		return "", err
	}

	path := url.EscapedPath()
	parts := strings.Split(path, ".")
	return parts[len(parts)-1], nil
}
