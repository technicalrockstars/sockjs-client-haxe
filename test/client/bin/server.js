/*
	sockjs-client binding for haxe / test server
*/

// パッケージ
var http = require('http');
var sockjs = require('sockjs');

// クライアントリスト
var clients = {};

// 全クライアントに送信
function broadcast( message ) {
	for ( var client in clients ){
		clients[client].write( JSON.stringify( message ) );
	}
}

// sockjs サーバーを作る
var echo = sockjs.createServer( );

// コネクションイベント
echo.on( 'connection', function( conn ) {
	// クライアント追加
	clients[conn.id] = conn;

	// 受信時
	conn.on( 'data', function( message ) {
		console.log( message );
		broadcast( JSON.parse( message ) );
	});

	// 切断時
	conn.on( 'close', function( ) {
		delete clients[conn.id];
	});
});

// HTTPサーバー
var server = http.createServer();
echo.installHandlers(server, {prefix:'/echo'});
server.listen(9999, '0.0.0.0');

