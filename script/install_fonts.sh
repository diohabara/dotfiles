#!/usr/bin/env bash
: "fonts" && {
  # Doc: https://gist.github.com/matthewjberger/7dd7e079f282f8138a9dc3b045ebefa0
  declare -a fonts=(
    JetBrainsMono
    RobotoMono
    Ubuntu
    UbuntuMono
  )

  # Doc: https://github.com/ryanoasis/nerd-fonts/branches
  version='2.3.3'
  fonts_dir="${HOME}/.local/share/fonts"

  if [[ ! -d "$fonts_dir" ]]; then
    mkdir -p "$fonts_dir"
  fi

  for font in "${fonts[@]}"; do
    zip_file="${font}.zip"
    download_url="https://github.com/ryanoasis/nerd-fonts/releases/download/v${version}/${zip_file}"
    echo "Downloading $download_url"
    if command -v wget &> /dev/null; then
      wget "$download_url"
    elif command -v curl &> /dev/null; then
      curl -L -o "$zip_file" "$download_url"
    else
      echo "Error: Neither wget nor curl is available"
      exit 1
    fi
    unzip -q "$zip_file" -d "$fonts_dir"
    rm "$zip_file"
  done

  find "$fonts_dir" -name '*Windows Compatible*' -delete
}
