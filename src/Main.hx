import haxe.Timer;

class Foobar {
	@:pecan.accept public static function async<T>(cb:(T->Void)->Void, ?ret:T->Void, ?co:pecan.ICo<Any, Any, Any>):T {
		cb(ret);
		return null;
	}

	@:pecan.action public static function delay(ms:Int, ?co:pecan.ICo<Any, Any, Any>):Void {
		haxe.Timer.delay(co.wakeup, ms);
		co.suspend();
	}
}

function main()
	pecan.Co.co({
		var i = 0;
		trace("Hello,");
		Foobar.delay(1000); // one second delay
		trace("Haxe!");
		var response = Foobar.async((ret) -> {
			i++;
			Timer.delay(() -> ret(1000), 3000);
		});
		trace(response);
		var response = Foobar.async((ret) -> {
			i++;
			Timer.delay(() -> ret({a: Math.random()}), 3000);
		});
		trace(response.a);
		var response = Foobar.async((ret) -> {
			i++;
			Timer.delay(() -> ret({a: Math.random()}), 3000);
		});
		trace(response.a);
		var response = Foobar.async((ret) -> {
			i++;
			Timer.delay(() -> ret({a: Math.random()}), 3000);
		});
		trace(response.a);
		var response = Foobar.async((ret) -> {
			i++;
			Timer.delay(() -> ret({a: i}), 3000);
		});
		trace(response.a);
	}).run();
