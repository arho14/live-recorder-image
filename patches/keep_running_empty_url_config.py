from pathlib import Path


main_py = Path("/app/main.py")
source = main_py.read_text(encoding="utf-8")

old = """        if not ini_URL_content.strip():
            input_url = input('请输入要录制的主播直播间网址（尽量使用PC网页端的直播间地址）:\\n')
            with open(url_config_file, 'w', encoding=text_encoding) as file:
                file.write(input_url)
"""

new = """        if not ini_URL_content.strip():
            if sys.stdin and sys.stdin.isatty():
                input_url = input('请输入要录制的主播直播间网址（尽量使用PC网页端的直播间地址）:\\n')
                with open(url_config_file, 'w', encoding=text_encoding) as file:
                    file.write(input_url)
            else:
                Path(url_config_file).touch()
                if first_start:
                    logger.info("URL_config.ini is empty; keeping the container alive while waiting for new URLs.")
                time.sleep(3)
                continue
"""

if old not in source:
    raise SystemExit("Could not find the URL_config.ini input block in /app/main.py")

main_py.write_text(source.replace(old, new), encoding="utf-8")
