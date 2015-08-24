package main

// Reddit data structure
type Page struct {
	Data struct {
		Children []struct {
			Data struct {
				Preview struct {
					Images []struct {
						Id     string
						Source struct {
							Url    string
							Width  int
							Height int
						}
					}
				}
			}
		}
	}
}

func (p *Page) CompressToImages() []Image {
	images := []Image{}
	for _, child := range p.Data.Children {
		if len(child.Data.Preview.Images) > 0 {
			image := child.Data.Preview.Images[0]
			newImage := Image{
				id:     image.Id,
				url:    image.Source.Url,
				width:  image.Source.Width,
				height: image.Source.Height,
			}
			if newImage.IsHorizontal() {
				images = append(images, newImage)
			}
		}
	}
	return images
}
