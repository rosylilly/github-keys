# Github::Keys

ギッハブから SSH 公開鍵をガバっと取ってくる、便利なコマンドラインツールです。

## Installation

install it yourself as:

    $ gem install github-keys
    $ github-keys -v

## Usage

基本的にはユーザー名を指定して取得します。

    $ github-keys rosylilly
    ssh-rsa ...

また、 Organization を指定して取得することもできます。

    $ github-keys cookpad
    ssh-rsa ...

Organization を指定した場合、認証していないと publcize membership していないメンバーは取れないので、認証しながらとるときは以下のオプションを指定します。

    $ github-keys -u rosylily -p hogehoge cookpad
    ssh-rsa ...

コマンドログに認証情報が乗るのが耐えられない人は、 HOME はカレントディレクトリに `.github-keysrc` というファイルを作って、中にこんな感じで書くと認証できます。

    $ cat .github-keysrc
    login: rosylilly
    password: hogehoge

引っ張ってくるユーザーは複数同時に指定出来ます。

    $ github-keys rosylilly yoshiori

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
