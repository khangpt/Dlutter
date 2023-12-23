## Make it ease to typing

- Think about this:

```dart
    InkWell(
        onTap: () {
          print('do something here');
        },
        child: const Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: SizedBox(
            width: double.infinity,
            child: Center(
              child: Text(
                'cancel',
                style: TextStyle(fontSize: 14, color: Colors.red),
              ),
            ),
          ),
        ),
      )
```

- And how about this:

```dart
    'cancel'
            .toText(size: 14, color: Colors.red)
            .toCenter()
            .toSizedBox(double.infinity)
            .toPadding(10.toEdgePaddingVertical())
            .toInkWell(
        onTap: () {
            print('do something here');
        },
    )
```

## Caution

- do not recommend to use this coding style for a huge page with expensive & complicated layout
- should break a huge layout into small pieces and manipulating this coding style
- refer to this discussion thread: [function widget vs class widget](https://stackoverflow.com/a/53234826/1716261)
- finally, enjoy and show your style!!!
