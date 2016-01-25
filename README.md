# autoloader
An automatic class-loader for D.

## Hello World

Create a class that you want to load,

```d
module app.hello_world;

class HelloWorld
{
    // Your class
}
```

Create an autoloader and load the class,

```d
import autoloader;

void main()
{
    // Tell our autoloader to search in 'app'
    auto loader = new BasicAutoloader(["app"]);
    
    // Load and construct HelloWorld
    Object o = loader.create("HelloWorld");
}
```

## Conventions

The autoloader is designed around convention over configuration, so it assumes that a class is located in a module under the same name but in lower_snake_case. For example,

| Class       | Relative Search Path        |
|-------------|-----------------------------|
| Foo         | `foo.Foo                  ` |
| BAR         | `bar.BAR                  ` |
| URLParser   | `url_parser.URLParser     ` |
| HttpService | `http_service.HttpService ` |

Overriding the `lookup(name)` function allows classes to change this behaviour.

## License

MIT
