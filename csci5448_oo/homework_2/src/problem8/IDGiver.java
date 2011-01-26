package problem8;

public class IDGiver {
	private static Integer idCounter = 0;
	public static synchronized Integer getNewId(){
		idCounter += 1;
		return idCounter;
	}
}
