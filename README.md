# WebArchiveCodable

![Stable Diffusion prompt: "Clean, sharp, document icon, Safari browser logo compass on a stylized clipboard, by Mac OS X, gradients, Colorful, icon, 3D Render"](.github/logo.jpg)

Exposes legacy WebKit WebArchive as a Swift Codable to e.g. access pasteboard data from Safari


## Test Fixture Attribution

- `adele-for-vogue-in-2021.webarchive`<br>
  <https://commons.wikimedia.org/wiki/File:Adele_for_Vogue_in_2021.png><br>
  Condé Nast (through Vogue Taiwan), CC BY 3.0 <https://creativecommons.org/licenses/by/3.0>, via Wikimedia Commons
- `christiantietze.de-post.webarchive`<br>
  <https://christiantietze.de/posts/2022/11/nstableview-variable-row-heights-broken-macos-ventura-13-0/><br>
  Christian Tietze, CC BY SA 4.0 <https://creativecommons.org/licenses/by-sa/4.0/>

## Thanks

- Oliver Drobnik's [post at Cocoanetics](https://www.cocoanetics.com/2011/09/decoding-safaris-pasteboard-format/) that brought up the idea to not use WebKit objects, but simpler representations.
- [Diffusion Bee](https://diffusionbee.com/) for the macOS stable diffusion app to generate a wonky logo via "`Clean, sharp, document icon, Safari browser logo compass on a stylized clipboard, by Mac OS X, gradients, Colorful, icon, 3D Render`"

## License

Copyright &copy; 2022 [Christian Tietze](https://christiantietze.de). Distributed under the MIT License. See [LICENSE file](./LICENSE) for details.
