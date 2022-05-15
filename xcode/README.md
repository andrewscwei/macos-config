# Xcode Configuration

Custom Xcode configuration—simply run the install script and you're good to go.

## Usage

### Installing Config

Install via Wget:

```sh
$ curl -o- -s https://raw.githubusercontent.com/andrewscwei/xcode-config/master/install.sh | bash
```

Relaunch Xcode and go to **Preferences**:

1. Go to **Key Bindings** and change **Key Binding Set** to *Custom*
2. Go to **Fonts and Colors** and select your favorite theme

### Exporting Existing Config

```sh
$ git clone https://github.com/andrewscwei/xcode-config
$ cd xcode-config
$ ./export.sh
```
