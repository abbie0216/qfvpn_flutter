// +build premium

package config

import "github.com/Dreamacro/clash/config"

func forEachProviders(rawCfg *config.RawConfig, fun func(index int, total int, key string, provider map[string]interface{})) {
	total := len(rawCfg.ProxyProvider) + len(rawCfg.RuleProvider)
	index := 0

	for k, v := range rawCfg.ProxyProvider {
		fun(index, total, k, v)

		index++
	}

	for k, v := range rawCfg.RuleProvider {
		fun(index, total, k, v)

		index++
	}
}

func destroyProviders(cfg *config.Config) {
	for _, p := range cfg.ProxyProviders {
		_ = p.Destroy()
	}

	for _, p := range cfg.RuleProviders {
		_ = p.Destroy()
	}
}
