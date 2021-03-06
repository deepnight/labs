/**
	Docs:
		https://gist.github.com/Yanrishatum/6eb2f6de05fc951599d5afccfab8d0a9
		https://heaps.io/documentation/hxsl.html
**/

class Main extends dn.Process {
	public static var ME : Main;
	var tf : h2d.Text;
	public var bg : h2d.Bitmap;

	public function new() {
		super();
		createRoot(Boot.ME.s2d);
		ME = this;
		fit(160,100);

		bg = new h2d.Bitmap( h2d.Tile.fromColor(0x444444) );
		root.add(bg,0);

		// FPS field
		var font = hxd.Res.fonts.minecraftiaOutline.toFont();
		tf = new h2d.Text(font);
		root.add(tf,99);
		tf.textColor = 0xffffff;

		// Bind 1-9 keys to lab classes
		Boot.ME.s2d.addEventListener((ev)->{
			switch ev.kind {
				case EKeyDown:
					if( ev.keyCode>=K.NUMBER_1 && ev.keyCode<=K.NUMBER_9 )
						runLab( ev.keyCode-K.NUMBER_1 );
				case _:
			}
		});
		runLab(0);

		Process.resizeAll();
	}

	function runLab(idx:Int) {
		killAllChildrenProcesses();
		switch idx {
			case 0: new Lab();
			case 1: new Darkness();
			case 2: new Outline();
		}
	}

	public inline function fit(w:Float,h:Float) {
		Boot.ME.s2d.scaleMode = AutoZoom(M.ceil(w),M.ceil(h), true);
		// Boot.ME.s2d.scaleMode = Zoom(2);
	}
	override function onResize() {
		super.onResize();
		bg.scaleX = w();
		bg.scaleY = h();
	}

	override function update() {
		super.update();
		tf.text = ""+M.pretty( hxd.Timer.fps(),0 );
	}
}

