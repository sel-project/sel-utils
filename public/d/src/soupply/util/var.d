/*
 * Copyright (c) 2016-2018 sel-project
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 *
 */
module soupply.util.var;

import std.traits : isNumeric, isIntegral, isSigned, isUnsigned, Unsigned;

struct var(T) if(isNumeric!T && isIntegral!T && T.sizeof > 1)
{
	
	alias U = Unsigned!T;
	
	public static immutable U MASK = U.max - 0x7F;
	public static immutable size_t MAX_BYTES = T.sizeof * 8 / 7 + (T.sizeof * 8 % 7 == 0 ? 0 : 1);
	public static immutable size_t RIGHT_SHIFT = (T.sizeof * 8) - 1;
	
	public static pure nothrow @safe ubyte[] encode(T value)
	{
		ubyte[] buffer;
		static if (isUnsigned!T)
		{
			U unsigned = value;
		}
		else
		{
			U unsigned;
			if (value >= 0)
				unsigned = cast(U)(value << 1);
			else if (value < 0)
				unsigned = cast(U)((-value << 1) - 1);
		}
		while ((unsigned & MASK) != 0)
		{
			buffer ~= unsigned & 0x7F | 0x80;
			unsigned >>>= 7;
		}
		buffer ~= unsigned & 0xFF;
		return buffer;
	}

	public static pure nothrow @trusted T decode(ubyte[] buffer, size_t index=0)
	{
		return decode(buffer, &index);
	}
	
	public static pure nothrow @safe T decode(ubyte[] buffer, size_t* index)
	{
		if (buffer.length <= *index) return T.init;
		U unsigned = 0;
		size_t j, k;
		do
		{
			k = buffer[*index];
			unsigned |= cast(U)(k & 0x7F) << (j++ * 7);
		} while (++*index < buffer.length && j < MAX_BYTES && (k & 0x80) != 0);
		static if (isUnsigned!T)
		{
			return unsigned;
		}
		else
		{
			T value = unsigned >> 1;
			if (unsigned & 1)
			{
				value++;
				return -value;
			}
			else
			{
				return value;
			}
		}
	}

	public static pure nothrow @trusted T fromBuffer(ref ubyte[] buffer)
	{
		size_t index = 0;
		auto ret = decode(buffer, &index);
		buffer = buffer[index..$];
		return ret;
	}
	
	public enum stringof = "var" ~ T.stringof;
	
}

alias varshort = var!short;

alias varushort = var!ushort;

alias varint = var!int;

alias varuint = var!uint;

alias varlong = var!long;

alias varulong = var!ulong;
	