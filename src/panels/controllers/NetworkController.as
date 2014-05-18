package panels.controllers {
	import common.Controller;
	import flash.display.Stage;
	import flash.events.DataEvent;
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.geom.Vector3D;
	import flash.net.Socket;

	public class NetworkController implements Controller {
		public function NetworkController(s:Stage, host:String, port:uint) {
			stage = s;
			startNetworkListener(host, port);
		}
		
		public function getOrientation() : Vector3D {
			return orientation
		}
		
		function startNetworkListener(host:String, port:uint) : void {
			socket = new Socket();
			socket.timeout = 500;
			configListeners(socket);
			if (host && port) socket.connect(host, port);
			socket.writeUTF("start");
		}
			
		function configListeners(dispatcher:IEventDispatcher):void {
			dispatcher.addEventListener(Event.CLOSE, closeHandler);
			dispatcher.addEventListener(Event.CONNECT, connectHandler);
			dispatcher.addEventListener(DataEvent.DATA, dataHandler);
			dispatcher.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			dispatcher.addEventListener(ProgressEvent.PROGRESS, progressHandler);
			dispatcher.addEventListener(ProgressEvent.SOCKET_DATA, responseHandler);
			dispatcher.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
		}
		
		function readResponse():void{
			recvstr = socket.readUTFBytes(socket.bytesAvailable);
			updateOrientation(recvstr);
		}
		
		function responseHandler(event:ProgressEvent):void {
			readResponse();
		}
		
		function closeHandler(event:Event):void {
			trace("Connection lost. Switching to keyboard.");
			// SEND EVENT TO WARN OF FAILURE?
		}
		
		function connectHandler(event:Event):void {
			trace("[DEBUG] Connected.");
		}
		
		function dataHandler(event:DataEvent):void {
			trace("dataHandler: " + event);
		}
		
		function ioErrorHandler(event:IOErrorEvent):void {
			trace("Network error. Switching to keyboard.");
			// SEND EVENT TO WARN OF FAILURE?
		}
		
		function progressHandler(event:ProgressEvent):void {
			trace("progressHandler loaded:" + event.bytesLoaded + " total: " + event.bytesTotal);
		}
		
		function securityErrorHandler(event:SecurityErrorEvent):void {
			trace("Controller is offline. Switching to keyboard.");
			// SEND EVENT TO WARN OF FAILURE?
		}
		
		function toScale(degrees:int) : Number{
			var output:Number;
			output = degrees;
			return (output-180)/180;
		}
		
		function updateOrientation(s:String): void {
			try{
				var temp:Array= s.split(";");
				orientation.x = toScale(temp[0])
				orientation.y = toScale(temp[1]);
				orientation.z = toScale(temp[2]);
			}
			catch (error:Error) {}
		}
		
		var socket:Socket;
		var recvstr:String;
		var orientation:Vector3D;
		var stage:Stage;
	}
}