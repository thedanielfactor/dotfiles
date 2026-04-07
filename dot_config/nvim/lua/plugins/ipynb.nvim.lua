return {
    "ansh-info/ipynb.nvim",
    lazy = false,
    build = "uv sync --project python/ || (python3 -m venv python/.venv && python/.venv/bin/pip install ./python/)",
    dependencies = {
        "nvim-treesitter/nvim-treesitter"
    },
    opts = {}
}