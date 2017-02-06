/*
 * This file was automatically generated by sel-utils and
 * released under the GNU General Public License version 3.
 *
 * License: https://github.com/sel-project/sel-utils/blob/master/LICENSE
 * Repository: https://github.com/sel-project/sel-utils
 */
package sul.protocol.hncom1;

import java.util.Collections;
import java.util.Map;
import java.util.HashMap;

import sul.utils.Packet;

/**
 * Protocol used for the communication between an hub and multiple nodes with support
 * for Minecraft and Minecraft: Pocket Edition and different protocol versions.
 * 
 * <h2>Definitions</h2>
 * 
 * <h3>Hub</h3>
 * The hub is the network part of the game server and handles pings, login sequences,
 * keep alive packets, queries, external consoles and everything else that is not a
 * gameplay feature.
 * A server can work with only an hub (nodeless) but every player that will try to
 * join the server will be disconnected with an "End of Stream" message after the login
 * process.
 * 
 * <h3>Node</h3>
 * The node is the gameplay part of the game server. It contains worlds and entities
 * and has only one network connection, with the hub.
 */
public final class Packets {

	private Packets() {}

	/**
	 * Packets used during the authentication process to exchange informations.
	 */
	public static final Map<Integer, Class<? extends Packet>> LOGIN;

	public static final Map<Integer, Class<? extends Packet>> STATUS;

	public static final Map<Integer, Class<? extends Packet>> PLAYER;

	static {

		HashMap<Integer, Class<? extends Packet>> login = new HashMap<Integer, Class<? extends Packet>>();
		login.put(0, sul.protocol.hncom1.login.ConnectionRequest.class);
		login.put(1, sul.protocol.hncom1.login.ConnectionResponse.class);
		login.put(2, sul.protocol.hncom1.login.HubInfo.class);
		login.put(3, sul.protocol.hncom1.login.NodeInfo.class);
		LOGIN = Collections.unmodifiableMap(login);

		HashMap<Integer, Class<? extends Packet>> status = new HashMap<Integer, Class<? extends Packet>>();
		status.put(4, sul.protocol.hncom1.status.AddNode.class);
		status.put(5, sul.protocol.hncom1.status.RemoveNode.class);
		status.put(6, sul.protocol.hncom1.status.MessageServerbound.class);
		status.put(7, sul.protocol.hncom1.status.MessageClientbound.class);
		status.put(8, sul.protocol.hncom1.status.Players.class);
		status.put(9, sul.protocol.hncom1.status.ResourcesUsage.class);
		status.put(10, sul.protocol.hncom1.status.Logs.class);
		status.put(11, sul.protocol.hncom1.status.RemoteCommand.class);
		status.put(12, sul.protocol.hncom1.status.UpdateList.class);
		status.put(13, sul.protocol.hncom1.status.Reload.class);
		STATUS = Collections.unmodifiableMap(status);

		HashMap<Integer, Class<? extends Packet>> player = new HashMap<Integer, Class<? extends Packet>>();
		player.put(14, sul.protocol.hncom1.player.Add.class);
		player.put(15, sul.protocol.hncom1.player.Remove.class);
		player.put(16, sul.protocol.hncom1.player.Kick.class);
		player.put(17, sul.protocol.hncom1.player.Transfer.class);
		player.put(18, sul.protocol.hncom1.player.UpdateLanguage.class);
		player.put(19, sul.protocol.hncom1.player.UpdateDisplayName.class);
		player.put(20, sul.protocol.hncom1.player.UpdateWorld.class);
		player.put(21, sul.protocol.hncom1.player.UpdateLatency.class);
		player.put(22, sul.protocol.hncom1.player.UpdatePacketLoss.class);
		player.put(23, sul.protocol.hncom1.player.GamePacket.class);
		player.put(24, sul.protocol.hncom1.player.OrderedGamePacket.class);
		PLAYER = Collections.unmodifiableMap(player);

	}

}
