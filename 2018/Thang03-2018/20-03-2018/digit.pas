const   ginp='digit.inp';
        gout='digit.out';

var     gi,go:text;
        a,b,k:int64;
        vtd,vtc,ans:longint;
        du:array[0..100001] of int64;
        ck:array[0..100001] of longint;
        ok:boolean;

procedure input;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        read(gi,a,b,k);
end;

procedure timck;
var     i:longint;
begin
        vtc:=0;
        ok:=false;
        a:=(a mod b)*10;
        repeat
                if (a=0) then
                begin
                        ok:=true;
                        exit;
                end;
                for i:=1 to vtc do
                        if (a mod b=du[i]) and (a div b=ck[i]) then
                        begin
                                vtd:=i;
                                exit;
                        end;
                inc(vtc);
                du[vtc]:=a mod b;
                ck[vtc]:=a div b;
                a:=(a mod b)*10;
        until false;
end;

function process:longint;
begin
        if ok=true then
        begin
                if vtc<k then exit(0) else exit(ck[k])
        end;
        if k<vtc then exit(ck[k]);
        k:=(k-vtd+1) mod (vtc-vtd+1);
        if k=0 then exit(ck[vtc]) else exit(ck[vtd+k-1]);
end;

procedure output;
begin
        ans:=process;
        write(go,ans);
        close(gi);close(go);
end;

begin
        input;
        timck;
        output;
end.













