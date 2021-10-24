const   ginp='ss.inp';
        gout='szs.out';
        base=311;
        kk=round(1e6)+7;

var     gi,go:text;
        n,k:longint;
        a:ansistring;
        h,p:array[0..50010] of int64;

procedure input;
var     i:longint;
begin
        readln(gi,n,k);
        read(gi,a);
        h[0]:=0;p[0]:=1;
        for i:=1 to n do
        begin
                h[i]:=(h[i-1]*base+ord(a[i])) mod kk;
                p[i]:=(p[i-1]*base) mod kk;
        end;
end;

procedure process;
var     i,d,c,m,mh:longint;
        cou:array[0..kk] of longint;
        ok:boolean;
begin
        if k=1 then
        begin
                write(go,n);exit;
        end;
        d:=1;c:=n;
        while d<>c do
        begin
                m:=(d+c) shr 1;
                fillchar(cou,sizeof(cou),0);
                for i:=m to n do
                begin
                        mh:=(h[i]-h[i-m]*p[m]+kk*kk) mod kk;
                        inc(cou[mh]);
                end;
                ok:=false;
                for i:=0 to kk do
                        if cou[i]>=k then ok:=true;
                if ok then d:=m+1 else c:=m;
        end;
        write(go,d-1);
end;

begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        input;
        process;
        close(gi);close(go);
end.
