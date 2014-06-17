package model.events;

import java.util.HashMap;

public class EventData {
	private String id;
	private String name;
	private String trigger;
	private HashMap<String, String> assignments;
	
	public EventData(String id, String name, String trigger, HashMap<String, String> assignments){
		this.id = id;
		this.name = name;
		this.trigger = trigger;
		this.assignments = assignments;
	}
	
	public String getId() {
		return id;
	}
	public String getName() {
		return name;
	}
	public String getTrigger() {
		return trigger;
	}
	public HashMap<String, String> getAssignments() {
		return assignments;
	}
}
