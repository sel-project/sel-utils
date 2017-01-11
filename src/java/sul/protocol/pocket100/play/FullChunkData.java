/*
 * This file has been automatically generated by sel-utils and
 * released under the GNU General Public License version 3.
 *
 * License: https://github.com/sel-project/sel-utils/blob/master/LICENSE
 * Repository: https://github.com/sel-project/sel-utils
 * Generator: https://github.com/sel-project/sel-utils/blob/master/xml/protocol/pocket100.xml
 */
package sul.protocol.pocket100.play;

import java.util.UUID;

import sul.protocol.pocket100.types.*;
import sul.utils.*;

class FullChunkData extends Packet {

	public final static byte ID = (byte)58;

	public final static boolean CLIENTBOUND = true;
	public final static boolean SERVERBOUND = false;

	public Tuples.IntXZ position;
	public byte[] data;
	public byte[] tiles;

	@Override
	public int length() {
	}

	@Override
	public byte[] encode() {
		this.buffer = new byte[this.length()];
		this.index = 0;
		this.writeByteB(ID);
		this.writeVarint(position.x);this.writeVarint(position.z);
		this.writeVaruint((int)data.length); for(ubyte zgf0yq:data){ this.writeByteB(zgf0yq); }
		this.writeVaruint((int)tiles.length); for(ubyte dglszxm:tiles){ this.writeByteB(dglszxm); }
		return this.buffer;
	}

	@Override
	public void decode(byte[] buffer) {
		this.buffer = buffer;
		this.index = 0;
	}

}