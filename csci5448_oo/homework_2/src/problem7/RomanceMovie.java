
package problem7;
public class RomanceMovie extends Movie {

	public RomanceMovie(String movieName) {
		super(movieName);
	}

	@Override
	public Double getPricePerDay() {
		// TODO Auto-generated method stub
		return 5.0;
	}

	@Override
	public String getCategory(){
		return "Chick Flick";
	}
}
