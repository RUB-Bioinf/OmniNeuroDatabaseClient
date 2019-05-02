package de.rub.bph.omnineuro.client.util;

import de.rub.bph.omnineuro.client.imported.filemanager.FileManager;
import de.rub.bph.omnineuro.client.imported.log.Log;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Objects;
import java.util.Random;

public class CodeHasher {

	public static final int ALPHABET_CHAR_COUNT = 26;
	public static final int ALPHABET_CAR_A_INDEX = 65;
	public static final int DEFAULT_SALT = 3763735;

	private int myHash;
	private int hashSalt;

	public CodeHasher(Object data) {
		myHash = data.hashCode();
		setHashSalt(DEFAULT_SALT);
	}

	public static void searchHash(int startSalt, int length, String data, String hashTarget, int findingCount) throws IOException {
		FileManager manager = new FileManager();
		int finds = 0;
		int salt = startSalt;
		File f = new File(new File("data"),"hash");
		f.mkdirs();
		f = new File(f, "hashTarget.csv");

		manager.appendFile(f, "Starting new search in '" + data + "'. Searching for hash: '" + hashTarget + "'");
		manager.appendFile(f, "index;timestamp;salt;result");

		while (finds < findingCount) {
			CodeHasher hasher = new CodeHasher(data);
			hasher.setHashSalt(salt);
			String s = hasher.getCodeHash(length);
			Log.v(salt + ": " + s);

			if (s.contains(hashTarget)) {
				finds++;
				Log.i("Found! " + salt + ": " + s);
				String timestamp = new SimpleDateFormat("dd.MM-hh:mm:ss").format(new Date());
				manager.appendFile(f, finds + ";" + timestamp + ";" + salt + ";" + s);
			}
			salt++;
		}
	}

	public int getHashSalt() {
		return hashSalt;
	}

	public void setHashSalt(int hashSalt) {
		this.hashSalt = hashSalt;
	}

	public String getCodeHash(int length) {
		StringBuilder builder = new StringBuilder();
		Random r = new Random(getTraditionalHash() + getHashSalt());

		for (int i = 0; i < length; i++) {
			char c = (char) (r.nextInt(ALPHABET_CHAR_COUNT) + ALPHABET_CAR_A_INDEX);
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
