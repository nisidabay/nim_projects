.PHONY: build debug deps install uninstall test clean run

# Build targets
build:
	nim c -d:release --out:bin/youtube_downloader youtube_downloader.nim

debug:
	nim c -d:debug --out:bin/youtube_downloader youtube_downloader.nim

# Install targets
deps:
	# Installs nimble dependencies
	nimble install -y

install: build
	# Installs the app binary to ~/bin
	@mkdir -p ~/bin
	@cp bin/youtube_downloader ~/bin/
	@echo "Installed youtube_downloader to ~/bin/"

uninstall:
	# Removes the app binary from ~/bin
	@rm -f ~/bin/youtube_downloader
	@echo "Removed youtube_downloader from ~/bin/"

# Other targets
test:
	nim c -r tests/test_downloader.nim

clean:
	rm -rf bin/ 

run:
	nim c -r youtube_downloader.nim $(ARGS)
