# LocalStorage Light

## Getting Started

```dart
import 'package:localstorage_light/main.dart';

final localStorage = await LocalStorage.init('my_localstore_test');
print(localStorage.getItem('hello')); //null
await localStorage.setItem('hello', 'HELLO');
print(localStorage.getItem('hello')); //HELLO

await localStorage.setItem('world', 'WORLD');
print(localStorage.getItem('world')); //WORLD

await localStorage.removeItem('world');
print(localStorage.getItem('world')); //null

await localStorage.clear();
print(localStorage.getItem('hello')); //null
print(localStorage.getItem('world')); //null
```
