package bootstrap

import (
	"embed"
	"blog/pkg/view"
)

// SetupTemplate 模板初始化
func SetupTemplate(tmplFS embed.FS) {

	view.TplFS = tmplFS

}
