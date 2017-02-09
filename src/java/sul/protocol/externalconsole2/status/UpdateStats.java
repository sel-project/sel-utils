/*
 * This file was automatically generated by sel-utils and
 * released under the GNU General Public License version 3.
 *
 * License: https://github.com/sel-project/sel-utils/blob/master/LICENSE
 * Repository: https://github.com/sel-project/sel-utils
 * Generated from https://github.com/sel-project/sel-utils/blob/master/xml/protocol/externalconsole2.xml
 */
package sul.protocol.externalconsole2.status;

import java.util.Arrays;

import sul.utils.*;

/**
 * Updates the statistics about the usage of the server and, eventually, the connected
 * nodes.
 * This packet is sent in response to RequestStats and every time the server retains
 * that the stats should be updated (usually in a range of 5 to 30 seconds).
 */
public class UpdateStats extends Packet {

	public static final byte ID = (byte)3;

	public static final boolean CLIENTBOUND = true;
	public static final boolean SERVERBOUND = false;

	/**
	 * Number of players currently online on the server. Players that are performing authentication
	 * are not included in the count.
	 */
	public int onlinePlayers;

	/**
	 * Highest number of players that can join the server simultaneously. If 0, there is
	 * not maximum number of players.
	 */
	public int maxPlayers;

	/**
	 * Milliseconds since the server has started.
	 */
	public int uptime;

	/**
	 * Average amount of bytes sent every second.
	 */
	public int upload;

	/**
	 * Average amount of bytes sent every second.
	 */
	public int download;

	/**
	 * Resources usage of the connected nodes, if the server uses the hub-node layout,
	 * or an empty list.
	 */
	public sul.protocol.externalconsole2.types.NodeStats[] nodes;

	public UpdateStats() {}

	public UpdateStats(int onlinePlayers, int maxPlayers, int uptime, int upload, int download, sul.protocol.externalconsole2.types.NodeStats[] nodes) {
		this.onlinePlayers = onlinePlayers;
		this.maxPlayers = maxPlayers;
		this.uptime = uptime;
		this.upload = upload;
		this.download = download;
		this.nodes = nodes;
	}

	@Override
	public int length() {
		int length=23; for(sul.protocol.externalconsole2.types.NodeStats bm9kzxm:nodes){ length+=bm9kzxm.length(); } return length;
	}

	@Override
	public byte[] encode() {
		this._buffer = new byte[this.length()];
		this.writeBigEndianByte(ID);
		this.writeBigEndianInt(onlinePlayers);
		this.writeBigEndianInt(maxPlayers);
		this.writeBigEndianInt(uptime);
		this.writeBigEndianInt(upload);
		this.writeBigEndianInt(download);
		this.writeBigEndianShort((short)nodes.length); for(sul.protocol.externalconsole2.types.NodeStats bm9kzxm:nodes){ this.writeBytes(bm9kzxm.encode()); }
		return this.getBuffer();
	}

	@Override
	public void decode(byte[] buffer) {
		this._buffer = buffer;
		readBigEndianByte();
		onlinePlayers=readBigEndianInt();
		maxPlayers=readBigEndianInt();
		uptime=readBigEndianInt();
		upload=readBigEndianInt();
		download=readBigEndianInt();
		int bg5vzgvz=readBigEndianShort(); nodes=new sul.protocol.externalconsole2.types.NodeStats[bg5vzgvz]; for(int bm9kzxm=0;bm9kzxm<nodes.length;bm9kzxm++){ nodes[bm9kzxm]=new sul.protocol.externalconsole2.types.NodeStats(); nodes[bm9kzxm]._index=this._index; nodes[bm9kzxm].decode(this._buffer); this._index=nodes[bm9kzxm]._index; }
	}

	public static UpdateStats fromBuffer(byte[] buffer) {
		UpdateStats ret = new UpdateStats();
		ret.decode(buffer);
		return ret;
	}

	@Override
	public String toString() {
		return "UpdateStats(onlinePlayers: " + this.onlinePlayers + ", maxPlayers: " + this.maxPlayers + ", uptime: " + this.uptime + ", upload: " + this.upload + ", download: " + this.download + ", nodes: " + Arrays.deepToString(this.nodes) + ")";
	}

}