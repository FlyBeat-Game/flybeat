package com.example.flybeatremote;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.net.InetAddress;
import java.net.NetworkInterface;
import java.net.ServerSocket;
import java.net.Socket;
import java.net.SocketException;
import java.util.Enumeration;

import android.hardware.Sensor;
import android.hardware.SensorEvent;
import android.hardware.SensorEventListener;
import android.hardware.SensorManager;
import android.os.Bundle;
import android.app.Activity;
import android.content.Context;
import android.util.Log;
import android.view.View;
import android.view.WindowManager;
import android.widget.Button;
import android.widget.TextView;

public class Controller extends Activity implements SensorEventListener {
	public String ipaddress;
	public ServerSocket s;
	public Socket accepted;
	public int ServerPort = 8087;
	public String data = "0;0;0";
	Thread serverThread = null;
	
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        getWindow().addFlags(WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON);
        setContentView(R.layout.activity_controller);
        TextView tvipaddress = (TextView) this.findViewById(R.id.tvipaddress);
        Button btexit = (Button)findViewById(R.id.btexit);
        btexit.setOnClickListener(new View.OnClickListener() {
            public void onClick(View v) { finish(); System.exit(0); }
        });
        ipaddress = getMyIpAddress();
        tvipaddress.setText("IP Address: " + ipaddress);
        SensorManager mSensorManager = (SensorManager) this.getSystemService(Context.SENSOR_SERVICE);
        Sensor asensor = mSensorManager.getDefaultSensor(Sensor.TYPE_ORIENTATION);
        mSensorManager.registerListener(this, asensor, SensorManager.SENSOR_DELAY_GAME);
        this.serverThread = new Thread(new ServerThread());
        this.serverThread.start();
    }
    
    public static String getMyIpAddress() {
        try {
            for (Enumeration<NetworkInterface> en = NetworkInterface.getNetworkInterfaces(); en.hasMoreElements();) {
                NetworkInterface intf = en.nextElement();
                for (Enumeration<InetAddress> enumIpAddr = intf.getInetAddresses(); enumIpAddr.hasMoreElements();) {
                    InetAddress inetAddress = enumIpAddr.nextElement();
                    if (!inetAddress.isLoopbackAddress()) {
                        return inetAddress.getHostAddress();
                    }
                }
            }
        } catch (SocketException ex) { }
        return null;
    }
    
    class ServerThread implements Runnable {
    	private BufferedReader input;

    	public void run() {
    		try { s = new ServerSocket(ServerPort); }
    		catch (IOException e) { e.printStackTrace(); }
    		try {
    			accepted = s.accept();
    			input = new BufferedReader(new InputStreamReader(accepted.getInputStream()));
    			PrintWriter outp = new PrintWriter(accepted.getOutputStream(), true);
    			while(true){
	    			outp.println(data+"\0");
	    			Thread.sleep(50);
    			}
    		}
    		catch (Exception e) { e.printStackTrace(); }
    	}
	}

	@Override
	public void onAccuracyChanged(Sensor arg0, int arg1) {
		// TODO 
	}

	@Override
	public void onSensorChanged(SensorEvent ev) {
		// TODO Auto-generated method stub
		TextView tvdebug1 = (TextView) this.findViewById(R.id.tvdebug1);
		int s = (int)ev.values[0];
		int d = -(int)(ev.values[1])+180; //neg - direita
		int h = (int)ev.values[2]+180; //neg - baixo
		data = d+";"+h+";"+"180";
		tvdebug1.setText(s + "\n" + h + "\n" + d);
	}
	
	public static void exitListener(){
		
	}
}

