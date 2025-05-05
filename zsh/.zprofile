# 检查是否在 Neovide 中运行
if [[ -n "$NVIM_GUI" ]]; then
    # 仅在 Neovide 中生效的配置
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi
