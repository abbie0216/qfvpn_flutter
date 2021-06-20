package config

import (
	"io/ioutil"
	P "path"
	"strings"

	"gopkg.in/yaml.v2"

	"cfa/app"

	"github.com/Dreamacro/clash/constant"
	"github.com/Dreamacro/clash/log"

	"github.com/Dreamacro/clash/config"
	"github.com/Dreamacro/clash/hub/executor"
)

func logDns(cfg *config.RawConfig) {
	bytes, err := yaml.Marshal(&cfg.DNS)
	if err != nil {
		log.Warnln("Marshal dns: %s", err.Error())

		return
	}

	log.Infoln("dns:")

	for _, line := range strings.Split(string(bytes), "\n") {
		log.Infoln("  %s", line)
	}
}

func UnmarshalAndPatch(profilePath string) (*config.RawConfig, error) {
	configPath := P.Join(profilePath, "config.yaml")

	configData, err := ioutil.ReadFile(configPath)
	if err != nil {
		return nil, err
	}

	rawConfig, err := config.UnmarshalRawConfig(configData)
	if err != nil {
		return nil, err
	}

	if err := process(rawConfig, profilePath); err != nil {
		return nil, err
	}

	return rawConfig, nil
}

func Parse(rawConfig *config.RawConfig) (*config.Config, error) {
	cfg, err := config.ParseRawConfig(rawConfig)
	if err != nil {
		return nil, err
	}

	return cfg, nil
}

func Load(path string) error {
	rawCfg, err := UnmarshalAndPatch(path)
	if err != nil {
		log.Errorln("Load %s: %s", path, err.Error())

		return err
	}

	logDns(rawCfg)

	cfg, err := Parse(rawCfg)
	if err != nil {
		log.Errorln("Load %s: %s", path, err.Error())

		return err
	}

	executor.ApplyConfig(cfg, true)

	app.ApplySubtitlePattern(rawCfg.ClashForAndroid.UiSubtitlePattern)

	return nil
}

func LoadDefault() {
	rawConfig, _ := config.UnmarshalRawConfig([]byte{})

	_ = patchDns(rawConfig, constant.Path.HomeDir())

	cfg, err := config.ParseRawConfig(rawConfig)
	if err != nil {
		panic(err.Error())
	}

	executor.ApplyConfig(cfg, true)
}

func init() {
	LoadDefault()
}
