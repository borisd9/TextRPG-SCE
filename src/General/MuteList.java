package General;

import java.util.ArrayList;

public class MuteList{
	
	
	private static ArrayList<String> muted = new ArrayList<String>();
	
	public synchronized boolean addToList(String name){
		if (!muted.contains(name)){
			muted.add(name);
			return true;
		}
		else return false;
	}
	
	public synchronized boolean removeFromList(String name){
		if (muted.contains(name)){
			muted.remove(name);
			return true;
		}
		else return false;
	}
	
	public ArrayList<String> getList(){
		return muted;
	}
}
