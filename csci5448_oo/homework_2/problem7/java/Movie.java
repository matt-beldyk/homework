
public abstract class Movie {
	private String movieName;
	
	public  String getCategory(){
		String className = this.getClass().getName();
		return className.replace("Movie", "");
	}
	public abstract Double getPricePerDay();
	public Movie(){
	
	}
	public Movie(String name){
		setMovieName(name);
	}
	public String toString(){
		return "Movie:: name:"+getMovieName()+", price:"+getPricePerDay()+", category:"+getCategory();
	}
	public void setMovieName(String movieName) {
		this.movieName = movieName;
	}
	public String getMovieName() {
		return movieName;
	}
}
