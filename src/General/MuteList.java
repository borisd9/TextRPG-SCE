package General;

import java.util.ArrayList;

public class MuteList{
	
	
	private static ArrayList<String> muted = new ArrayList<String>();
	
	public synchronized void addToList(String name){
		System.out.println(name);
		if (!muted.contains(name))
			muted.add(name);
	}
	
	public synchronized void removeFromList(String name){
		muted.remove(name);
	}
	
	public static ArrayList getList(){
		return muted;
	}
}
