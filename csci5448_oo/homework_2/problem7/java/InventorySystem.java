import java.util.ArrayList;
import java.util.Collection;


public class InventorySystem {

	private Collection<Category> categories;
	public InventorySystem(){
		categories = new ArrayList<Category>();
	}

	public void addCategory(Category cat){
		categories.add(cat);
	}

	public String toString(){
		StringBuilder tmp = new StringBuilder();
		tmp.append("InventorySystem:");
		for(Category c: categories){
			tmp.append(c);
		}
		return tmp.toString();
	}

	public String getCategorySummaryReport(){
		StringBuilder tmp = new StringBuilder();
		tmp.append("**************************\n");
		tmp.append("* Movie Inventory System *\n");
		tmp.append("*  Movies Per Category   *\n");
		tmp.append("**************************\n");

		for(Category c: categories){
			tmp.append(c.getCategoryName() + ":\t"+c.getCountMovies()+"\n");
		}
		tmp.append("**************************\n");
		
		return tmp.toString();
	}
	
	public Double calcCostToRentAllMovies4OneDay(){
		Double ticker = 0.0;
		for(Category c: categories){
			ticker = ticker+ c.getCostToRentAll4OneDay();
		}
		return ticker;
	}

}
