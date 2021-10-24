Const   ginp='string.inp';
        gout='string.out';
        maxn=1000010;
        base=211;
        mol=trunc(1e9)+13;

Var     m,q,ms:longint;
        s:ansistring;
        res:int64;
        lg:array[0..maxn] of longint;
        hash,h:array[0..maxn] of int64;
        pow:array[0..maxn] of int64;

Function Get(l,r:longint):int64;
Begin
        get:=(h[r]-h[l-1]*pow[r-l+1]+mol*mol) mod mol;
End;

Procedure Process1;
Var     i:longint;
        hs:int64;
Begin
        hs:=0;
        for i:=1 to length(s) do hs:=(hs*base+ord(s[i])) mod mol;
        for i:=1 to m do
                if hash[i]=hs then exit;
        inc(m);
        hash[m]:=hs; lg[m]:=length(s);
End;

Procedure Process2;
Var     i,l,cou:longint;
Begin
        h[0]:=0;
        for i:=1 to length(s) do h[i]:=(h[i-1]*base+ord(s[i])) mod mol;
        res:=0;
        for i:=1 to m do
        begin
                cou:=0;
                for l:=1 to length(s)-lg[i]+1 do
                        if hash[i]=get(l,l+lg[i]-1) then inc(cou);
                res:=res+int64(cou)*lg[i];
        end;
        writeln(res);
End;

Begin
        Assign(input,ginp); Assign(output,gout);
        Reset(input); Rewrite(output);
        pow[0]:=1;
        for q:=1 to maxn do pow[q]:=(pow[q-1]*base) mod mol;
        readln(q);
        for q:=1 to q do
        begin
                read(ms); readln(s);
                while s[1]=' ' do delete(s,1,1);
                while s[length(s)]=' ' do delete(s,length(s),1);
                if ms=1 then Process1 else Process2;
        end;
        Close(input); Close(output);
End.
