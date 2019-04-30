package de.rub.bph.omnineuro.client.util;

import java.util.Objects;
import java.util.Random;

public class CodeHasher {

	private int myHash;

	public CodeHasher(Object data) {
		myHash = data.hashCode();
	}

	public String getCodeHash(int length) {
		StringBuilder builder = new StringBuilder();
		Random r = new Random(getTraditionalHash());

		for (int i = 0; i < length; i++) {
			char c = (char) (r.nextInt(26) + 65);
			builder.append(c);
		}
		return builder.toString();
	}

	@Override
	public boolean equals(Object o) {
		if (this == o) return true;
		if (o == null || getClass() != o.getClass()) return false;
		CodeHasher that = (CodeHasher) o;
		return myHash == that.myHash;
	}

	@Override
	public int hashCode() {
		return Objects.hash(myHash);
	}

	public int getTraditionalHash() {
		return myHash;
	}
}
