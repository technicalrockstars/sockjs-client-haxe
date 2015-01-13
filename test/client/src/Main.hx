package;

import haxe.Json;
import js.Browser;
import js.html.InputElement;
import js.html.TextAreaElement;
import sockjs.client.SockJS;

/**
 * sockjs client binding for haxe / test
 */
class Main
{
	private var sock:SockJS;

	/**
	 * エントリポイント
	 */
	static public function main( )
	{
		new Main( );
	}

	/**
	 * コンストラクタ
	 */
	public function new( )
	{
		Browser.window.onload = function( d:Dynamic ) {
			this.sock = new SockJS( "http://localhost:9999/echo" );

			this.sock.onopen = function( ev:SockJSEvent ) {
				this.showMessage( "opened" );
			};
			this.sock.onclose = function( ev:SockJSEvent ) {
				this.showMessage( "closed" );
			};
			this.sock.onerror = function( ev:SockJSEvent ) {
				this.showMessage( "error: " + ev );
			};
			this.sock.onmessage = function( ev:SockJSEvent ) {
				var d = Json.parse( Std.string( ev.data ) );
				if( d.mode == "message" ) {
					this.showMessage( "message: from[" + d.name + "] > " + d.msg );
				}else {
					this.showMessage( "recv: " + Std.string( ev ) );
				}
			};

			// 名前を適当にうめとく
			var nameList = [
				"なーじゃ", "ろーずまりー", "りた", "しるう゛ぃー"
				
			];
			cast( Browser.document.getElementById( "name" ), InputElement ).value = nameList[Std.random( nameList.length )];

			// クリックイベント
			Browser.document.getElementById( "send" ).onclick = function( d:Dynamic ) {
				this.sendMessage( );
			};
		};
	}

	/**
	 * メッセージ
	 */
	public function sendMessage( ):Void
	{
		var name = cast( Browser.document.getElementById( "name" ), InputElement ).value;
		var msg = cast( Browser.document.getElementById( "msg" ), InputElement ).value;

		this.sock.send( Json.stringify( { name: name, msg: msg, mode: "message" } ) );
	}

	/**
	 * メッセージ表示
	 * @param	s	メッセージ
	 */
	public function showMessage( s:String ):Void
	{
		var memo:TextAreaElement = cast Browser.document.getElementById( "memo" );
		memo.value += s + "\n";
	}
}
