return {
  "cameron-wags/rainbow_csv.nvim",
  config = true,
  ft = {
    "csv",
    "tsv",
    "csv_semicolon",
    "csv_whitespace",
    "csv_pipe",
    "rfc_csv",
    "rfc_semicolon",
  },
  cmd = {
    "RainbowDelim",
    "RainbowDelimSimple",
    "RainbowDelimQuoted",
    "RainbowMultiDelim",
    rcsv_colorpairs = [['red', 'red'], ['blue', 'blue'], ['green', 'green'], ['magenta', 'magenta'], ['NONE', 'NONE'], ['darkred', 'darkred'], ['darkblue', 'darkblue'], ['darkgreen', 'darkgreen'], ['darkmagenta', 'darkmagenta'], ['darkcyan', 'darkcyan']],
  },
}
