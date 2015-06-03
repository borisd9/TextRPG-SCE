package Servlets;

import java.io.IOException;
import java.nio.ByteBuffer;
import java.nio.CharBuffer;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.CopyOnWriteArraySet;
import java.util.concurrent.atomic.AtomicInteger;

import javax.servlet.http.HttpServletRequest;
import javax.websocket.Session;

import org.apache.catalina.websocket.MessageInbound;
import org.apache.catalina.websocket.StreamInbound;
import org.apache.catalina.websocket.WebSocketServlet;
import org.apache.catalina.websocket.WsOutbound;


public class ChatServlet extends WebSocketServlet {
		
	private static ArrayList<MyMessageInbound> mmiList = new ArrayList<MyMessageInbound>();
	
	@Override
	protected StreamInbound createWebSocketInbound(String subProtocol,
			HttpServletRequest request) {
		try {
			Thread.sleep(1000);
		} catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return new MyMessageInbound();
	}

	private class MyMessageInbound extends MessageInbound{
        WsOutbound myoutbound;

        @Override
        public void onOpen(WsOutbound outbound){
        	this.myoutbound = outbound;
			mmiList.add(this);
        }

        @Override
        public void onClose(int status){
            mmiList.remove(this);
        }

        @Override
        public void onTextMessage(CharBuffer cb) throws IOException{
            for(MyMessageInbound mmib: mmiList){
                CharBuffer buffer = CharBuffer.wrap(cb);
                mmib.myoutbound.writeTextMessage(buffer);
                mmib.myoutbound.flush();
            }
        }

        @Override
        public void onBinaryMessage(ByteBuffer bb) throws IOException{
        }
    }
	

}
