// +build !premium

package config

import "github.com/Dreamacro/clash/config"

func forEachProviders(rawCfg *config.RawConfig, fun func(index int, total int, key string, provider map[string]interface{})) {
	total := len(rawCfg.ProxyProvider)
	index := 0

	for k, v := range rawCfg.ProxyProvider {
		fun(index, total, k, v)

		index++
	}
}

func destroyProviders(cfg *config.Config) {
	for _, p := range cfg.Providers {
		_ = p.Destroy()
	}
}
