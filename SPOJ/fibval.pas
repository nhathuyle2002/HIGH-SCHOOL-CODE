const   ginp='ss.inp';
        gout='ss.out';
        ck=16;
        vt1=9;dk1=9;
        vt2=1;dk2=17;

var     gi,go:text;

function max(x,y,z:int64):int64;
begin
        max:=x;
        if y>max then max:=y;
        if z>max then max:=z;
        if max=0 then exit(-1);
end;

function ccl1(l,r:int64):int64;
begin
        if (r-l+1) div ck>=2 then ccl1:=((r-l+1) div ck)*ck
        else exit(0);
end;

function ccl2(l,r,vt,dk:int64):int64;
var     tm:int64;
begin
        if r<dk then exit(0);
        if r mod ck>=vt then tm:=r-r mod ck+vt
        else tm:=(r div ck)*ck-ck+vt;
        if tm-l>=1 then exit(2) else exit(0);
end;

procedure main;
var     i,t:longint;
        tm,l,r:int64;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,t);
        for i:=1 to t do
        begin
                readln(gi,l,r);
                tm:=max(ccl1(l,r),ccl2(l,r,vt1,dk1),ccl2(l,r,vt2,dk2));
                writeln(go,tm);
        end;
        close(gi);close(go);
end;

begin
        main;
end.

