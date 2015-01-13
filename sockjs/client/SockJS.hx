/*
	SockJS client for Haxe
		Programed by Yui Kinomoto

	TODO:
		Haxedocをキチンとする
		Dynamicをなんとかする
		あとで一部の英語を日本語化
*/

package sockjs.client;

import js.html.Blob;
import js.html.ArrayBuffer;
import js.html.ArrayBufferView;

typedef SockJSOption = {
	/// String to append to url for actual data connection. Defaults to a random 4 digit number.
	server:String,
	/// Sometimes it is useful to disable some fallback transports. This option allows you to supply a list transports that may be used by SockJS. By default all available transports will be used.
	transports:Array<String>
};

typedef SockJSEvent = Dynamic;

@:native("SockJS") extern class SockJS
{
	/// 接続中
	static public var CONNECTING( default, null ):Int;
	/// 開いている
	static public var OPEN( default, null ):Int;
	/// 切断中
	static public var CLOSING( default, null ):Int;
	/// 切断済み
	static public var CLOSED( default, null ):Int;

	/// ready state
	public var readyState( default, null ):Int;
	public var bufferedAmount( default, null ):Int;

	/**
	 * コンストラクタ
	 * @param	url			URL
	 * @param	_reserved	予約済
	 * @param	options		オプション
	 */
	public function new( url:String, ?_reserved:Dynamic, ?options:SockJSOption );

	// イベントハンドラ

	public var onopen:SockJSEvent->Void;
	public var onerror:SockJSEvent->Void;
	public var onclose:SockJSEvent->Void;
	public var extensions( default, null ):String;
	public var protocol( default, null ):String;

	/**
	 * 切断
	 * @param	code
	 * @param	reason	
	 */
	public function close( ?code:Int, ?reason:String ):Void;

	/// メッセージ受信
	public var onmessage:SockJSEvent->Void;
	/// バイナリタイプ
	public var binaryType:String;

	/**
	 * 送信
	 */
	@:overload(function( blob:Blob ):Void{})
	@:overload(function( ab:ArrayBuffer ):Void{})
	@:overload(function( abv:ArrayBufferView ):Void{})
	public function send( s:String ):Void;
}
