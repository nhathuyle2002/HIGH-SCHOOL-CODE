const   ginp='ss.inp';
        gout='ss.out';
        di:array[1..4] of longint=(-1,1,0,0);
        dj:array[1..4] of longint=(0,0,-1,1);

var     gi,go:text;
        m,n,r,ans:longint;
        a,dn,dd:array[0..201,0..201] of longint;
        si,sj:array[0..100000] of longint;
        d:array[0..201,0..201] of boolean;

procedure input;
var     i,j:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,m,n);
        for i:=0 to m+1 do
                for j:=0 to n+1 do a[i,j]:=-1;
        for i:=1 to m do
        begin
                for j:=1 to n do read(gi,a[i,j]);
                readln(gi);
        end;
end;

function ccl1(i,j:longint):longint;
var     k:longint;
begin
        ccl1:=0;
        for k:=3 to 4 do
                if a[i+di[k],j+dj[k]]=0 then inc(ccl1);
end;

function ccl2(i,j:longint):longint;
var     k:longint;
begin
        ccl2:=0;
        for k:=1 to 2 do
                if a[i+di[k],j+dj[k]]=0 then inc(ccl2);
end;

procedure up1(i,j:longint);
begin
        if (a[i,j]<>1) or (d[i,j]=false) then exit;
        dec(dd[i,j]);
        inc(r);
        si[r]:=i;
        sj[r]:=j;
end;

procedure up2(i,j:longint);
begin
        if (a[i,j]<>1) or (d[i,j]=false) then exit;
        dec(dn[i,j]);
        inc(r);
        si[r]:=i;
        sj[r]:=j;
end;

procedure update1(i,j:longint);
var     j0:longint;
begin
        inc(ans);
        j0:=j;
        repeat
                d[i,j0]:=false;
                dec(j0);
        until (a[i,j0]<>1) or (d[i,j0]=false) or (dn[i,j0]<dd[i,j0]);
        up2(i,j0-1);
        j0:=j;
        repeat
                d[i,j0]:=false;
                inc(j0);
        until (a[i,j0]<>1) or (d[i,j0]=false) or (dn[i,j0]<dd[i,j0]);
        up2(i,j0+1);
end;

procedure update2(i,j:longint);
var     i0:longint;
begin
        inc(ans);
        i0:=i;
        repeat
                up2(i0,j-1);up2(i0,j+1);
                d[i0,j]:=false;
                dec(i0);
        until (a[i0,j]<>1) or (d[i0,j]=false) or (dn[i0,j]<dd[i0,j]);
        up1(i0-1,j);
        i0:=i;
        repeat
                up2(i0,j-1);up2(i0,j+1);
                d[i0,j]:=false;
                inc(i0);
        until (a[i0,j]<>1) or (d[i0,j]=false) or (dn[i0,j]<dd[i0,j]);
        up1(i0+1,j);
end;

function ktt(i,j:longint):boolean;
begin
        if (a[i,j]<>1) or (d[i,j]=false) then exit(false);
        if (dd[i,j]=1) and (dn[i,j]=1) then exit(true) else exit(false);
end;

procedure xuli(i,j:longint);
var     k:longint;
begin
        if (a[i,j]<>1) or (d[i,j]=false) then exit;
        if (dn[i,j]>dd[i,j]) then update1(i,j) else
        if (dd[i,j]>dn[i,j]) then update2(i,j) else
        if (dd[i,j]=0) and (dn[i,j]=0) then
        begin
                inc(ans);
                d[i,j]:=false;
        end else
        if ktt(i,j) and ktt(i,j+1) and ktt(i+1,j) and ktt(i+1,j+1) then
        begin
                ans:=ans+2;
                d[i,j]:=false;d[i,j+1]:=false;d[i+1,j]:=false;d[i+1,j+1]:=false;
        end;
end;

procedure process;
var     i,j,k:longint;
begin
        for i:=1 to m do
                for j:=1 to n do
                begin
                        dn[i,j]:=ccl1(i,j);
                        dd[i,j]:=ccl2(i,j);
                end;
        fillchar(d,sizeof(d),true);
        r:=0;
        for i:=1 to m do
                for j:=1 to n do
                begin
                        xuli(i,j);
                        for k:=r downto 1 do xuli(si[k],sj[k]);
                        r:=0;
                end;
end;

procedure output;
begin
        write(go,ans);
        close(gi);close(go);
end;

begin
        input;
        process;
        output;
end.



