
public class Movie {

	private String movieName;
	public Movie(String name){
		setMovieName(name);
	}
	public String toString(){
		return "Movie:"+movieName;
	}
	public void setMovieName(String movieName) {
		this.movieName = movieName;
	}
	public String getMovieName() {
		return movieName;
	}
}
