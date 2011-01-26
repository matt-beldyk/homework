
package problem7;
public class ArtMovie extends Movie {

	public ArtMovie(String string) {
		super(string);
	}

	@Override
	public Double getPricePerDay() {
		return 8.0;
	}

}
