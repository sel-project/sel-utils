/*
 * This file was automatically generated by sel-utils and
 * released under the GNU General Public License version 3.
 * 
 * License: https://github.com/sel-project/sel-utils/blob/master/LICENSE
 * Repository: https://github.com/sel-project/sel-utils
 * Generated from https://github.com/sel-project/sel-utils/blob/master/xml/protocol/minecraft316.xml
 */
package sul.protocol.minecraft316.clientbound;

import java.nio.charset.StandardCharsets;

import sul.utils.*;

public class Respawn extends Packet {

	public static final int ID = (int)51;

	public static final boolean CLIENTBOUND = true;
	public static final boolean SERVERBOUND = false;

	@Override
	public int getId() {
		return ID;
	}

	// dimension
	public static final int NETHER = -1;
	public static final int OVERWORLD = 0;
	public static final int END = 1;

	// difficulty
	public static final byte PEACEFUL = 0;
	public static final byte EASY = 1;
	public static final byte NORMAL = 2;
	public static final byte HARD = 3;

	// gamemode
	public static final byte SURVIVAL = 0;
	public static final byte CREATIVE = 1;
	public static final byte ADVENTURE = 2;
	public static final byte SPECTATOR = 3;

	// level type
	public static final String INFINITY = "default";
	public static final String FLAT = "flat";
	public static final String AMPLIFIED = "amplified";
	public static final String LARGE_BIOMES = "largeBiomes";

	public int dimension;
	public byte difficulty;
	public byte gamemode;
	public String levelType;

	public Respawn() {}

	public Respawn(int dimension, byte difficulty, byte gamemode, String levelType) {
		this.dimension = dimension;
		this.difficulty = difficulty;
		this.gamemode = gamemode;
		this.levelType = levelType;
	}

	@Override
	public int length() {
		return Buffer.varuintLength(levelType.getBytes(StandardCharsets.UTF_8).length) + levelType.getBytes(StandardCharsets.UTF_8).length + 7;
	}

	@Override
	public byte[] encode() {
		this._buffer = new byte[this.length()];
		this.writeVaruint(ID);
		this.writeBigEndianInt(dimension);
		this.writeBigEndianByte(difficulty);
		this.writeBigEndianByte(gamemode);
		byte[] bvzxeb=levelType.getBytes(StandardCharsets.UTF_8); this.writeVaruint((int)bvzxeb.length); this.writeBytes(bvzxeb);
		return this.getBuffer();
	}

	@Override
	public void decode(byte[] buffer) {
		this._buffer = buffer;
		this.readVaruint();
		dimension=readBigEndianInt();
		difficulty=readBigEndianByte();
		gamemode=readBigEndianByte();
		int bvbvzxeb=this.readVaruint(); levelType=new String(this.readBytes(bvbvzxeb), StandardCharsets.UTF_8);
	}

	public static Respawn fromBuffer(byte[] buffer) {
		Respawn ret = new Respawn();
		ret.decode(buffer);
		return ret;
	}

	@Override
	public String toString() {
		return "Respawn(dimension: " + this.dimension + ", difficulty: " + this.difficulty + ", gamemode: " + this.gamemode + ", levelType: " + this.levelType + ")";
	}

}
