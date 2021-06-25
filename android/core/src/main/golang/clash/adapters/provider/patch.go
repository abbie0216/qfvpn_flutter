package provider

import "time"

var (
	defaultURLTestURL = "https://www.gstatic.com/generate_204"

	suspended bool
)

type UpdatableProvider interface {
	UpdatedAt() time.Time
}

func (f *fetcher) UpdatedAt() time.Time {
	return f.updatedAt
}

func Suspend(s bool) {
	suspended = s
}
