package results;

import java.util.Collection;

import results.BaseClass.Bool;
import results.BaseClass.ErrorLevel;

/**
 * When SMV/AV is run on a large set of modules, a CSV file is used to summarize
 * the results. An entry is created in the CSV file for each module. This class
 * represents the CSV entry.
 * 
 * Each CSV entry is uniquely identified by the name of the module in the field
 * 'module'. Hence module name is used in the hashCode(), equals() and
 * compareTo() methods.
 * 
 * When SMV/AV is run on a module, it will generate one of the following result:
 * Success, NormalBuild failed, InterceptedBuild failed, CreateBPL failed,
 * InstrumentChecks failed, Check failed. This result is stored in
 * 'smvErrorLevel'.
 * 
 * If the NormalBuild failed, it may be because of the unavailability of some
 * DLLs, which can be built by invoking the 'bcp' command in an admin razzle
 * environment. To address this, 'bcp' is invoked for the modules where
 * NormalBuild failed. This information is recorded in the flag 'bcpUsed' and
 * the result of 'bcp' is recorded in 'bcpErrorLevel' which can be: Success,
 * Failed.
 * 
 * Irrespective of whether 'bcp' succeeded or not, SMV/AV is again run on these
 * modules. The result of this execution is stored in 'bcpSmvErrorLevel'.
 * 
 * To summarize, the set of modules for which SMV/AV is successful should
 * satisfy the following: (smvErrorLevel == Success) OR ((smvErrorLevel ==
 * Failed) && (bcpUsed == True && bcpSmvErrorLevel == Success))
 * 
 * @author t-srg
 *
 */

public class CSVEntry implements Comparable<CSVEntry> {

	private Integer num;
	private String module;
	private ErrorLevel smvErrorLevel, bcpSmvErrorLevel;
	private Bool bcpUsed, bcpErrorLevel;

	public Integer getNum() {
		return num;
	}

	public void setNum(Integer num) {
		this.num = num;
	}

	public String getModule() {
		return module;
	}

	public void setModule(String module) {
		this.module = module;
	}

	public ErrorLevel getSmvErrorLevel() {
		return smvErrorLevel;
	}

	public void setSmvErrorLevel(ErrorLevel smvErrorLevel) {
		this.smvErrorLevel = smvErrorLevel;
	}

	public ErrorLevel getBcpSmvErrorLevel() {
		return bcpSmvErrorLevel;
	}

	public void setBcpSmvErrorLevel(ErrorLevel bcpSmvErrorLevel) {
		this.bcpSmvErrorLevel = bcpSmvErrorLevel;
	}

	public Bool getBcpUsed() {
		return bcpUsed;
	}

	public void setBcpUsed(Bool bcpUsed) {
		this.bcpUsed = bcpUsed;
	}

	public Bool getBcpErrorLevel() {
		return bcpErrorLevel;
	}

	public void setBcpErrorLevel(Bool bcpErrorLevel) {
		this.bcpErrorLevel = bcpErrorLevel;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((module == null) ? 0 : module.hashCode());
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		CSVEntry other = (CSVEntry) obj;
		if (module == null) {
			if (other.module != null)
				return false;
		} else if (!module.equals(other.module))
			return false;
		return true;
	}

	@Override
	public int compareTo(CSVEntry o) {
		return module.compareTo(o.module);
	}

	// Fetches the CSV entry for the module with name 'module'
	public static CSVEntry getCsvEntry(Collection<CSVEntry> entries, String module) {
		for (CSVEntry entry : entries)
			if (entry.getModule().equals(module))
				return entry;
		throw new RuntimeException("Module not found in the collection " + module);
	}

}