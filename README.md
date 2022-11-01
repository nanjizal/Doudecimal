# Doudecimal
Doudecimal, base 12 only Int.
  
### Allow simple use of Doudecimals.
  
For example
```Haxe
    var dd:Doudecimal_= {doudecimal:'2↊1'};
    trace( dd );
    trace( dd.toDozenal() );
    var v1: Doudecimal = 0;
    var v2: Doudecimal = '2A4';
    trace( v1+v2 );
```

### More complex use
  
It is ow possible with Doudecimal_Image and Doudecimal_Color using aspects reworked from pixelimage.
  
Visual tests / demo to follow. But antispated features.
  
- Color encoded as 143 levels per channel instead of 255, eg white is 'AAAAAA'.
- Communtive alpha blending  
- Triangle support
- Gradient 3 corner triangles
- Thick line and thick line gradient support
- Encoding 4 color 12-base color into 3 Uint8Array channels Doudecimal_Image
- Ability to setARGB as 0->1 color channels
- Transfer to canvas converting from 12-Base via to normal ARGB hex color, requires testing.
- Runs on Cppia ( no visual support yet ) and JS target, Neko has some abstract type bugs related to inline that are only partially resolved.  Probalbaly compiles on hxcpp and other targets.
  
#### TODO:
  
 - Add demo and investigate real use on Canvas, a put method compiles but not seen how well it works.
 - Since the Doudecimal_Image stores the date as Uint8Array is seems viable to save as PNG, JPG, GIF using the haxeFoundation Format library and just treating it like a normal ARGB image, some addition logic required to only allow viable sizes ( multiple of 4 probably ).
  
Technically the color stores one less Uint8 per ARGB encoding. This text layout diagram helps me visualise the internals.
  
```
  0xFF FF FF
  alpha       | red         | green         |  Blue       | 
  8         8 .    |  8     .   8      |  8 .       8     .
  1 2 3 1   2 3 1 2   3 1 2 3   1 2 3 1   2 3 1 2   3 1 2 3
 ```
