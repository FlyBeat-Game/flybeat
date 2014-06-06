package panels.controllers {
	import common.Controller;
	import flash.events.DataEvent;
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.geom.Vector3D;
	import flash.net.Socket;
	
	import panels.Panel;

	public class NetworkController implements Controller {
		public function NetworkController(panel:Panel,host:String, port:uint) {
			this.panel = panel;
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
		
		public function closeSocket(){
			if (isConnected) socket.close();
			isConnected = false;
		}
		
		function readResponse():void{
			recvstr = socket.readUTFBytes(socket.bytesAvailable);
			updateOrientation(recvstr);
		}
		
		function responseHandler(event:ProgressEvent):void {
			readResponse();
		}
		
		function closeHandler(event:Event):void {
			trace("[ANDROID] Connection lost.");
			isConnected = false;
			panel.stage.dispatchEvent(new Event("deviceFailure"));
		}
		
		function connectHandler(event:Event):void {
			trace("[ANDROID] Connected.");
			isConnected = true;
			panel.stage.dispatchEvent(new Event("deviceConnected"));
		}
		
		function dataHandler(event:DataEvent):void { }
		
		function ioErrorHandler(event:IOErrorEvent):void {
			trace("[ANDROID] Network error.");
			isConnected = false;
			panel.stage.dispatchEvent(new Event("deviceFailure"));
		}
		
		function progressHandler(event:ProgressEvent):void { }
		
		function securityErrorHandler(event:SecurityErrorEvent):void {
			trace("[ANDROID] Controller is offline.");
			isConnected = false;
			panel.stage.dispatchEvent(new Event("deviceFailure"));
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
		var isConnected:Boolean = false;
		var recvstr:String;
		var panel:Panel;
		var orientation:Vector3D  = new Vector3D;
	}
}