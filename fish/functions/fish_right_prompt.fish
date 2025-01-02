function fish_right_prompt
    # 显示 Conda 环境名称在右侧，并设置为绿色
    if set -q CONDA_DEFAULT_ENV
        echo -n (set_color green)"($CONDA_DEFAULT_ENV)"(set_color normal)
    end
end
