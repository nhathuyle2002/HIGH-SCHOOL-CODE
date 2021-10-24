const   ginp='table.inp';
        gout='table.out';

var     gi,go:text;
        n,dem:longint;
        t,t1,t2,vt1,vt2:int64;
        ans:string;

procedure input;
var     i:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        read(gi,n,t);
end;

procedure find;
begin
        t1:=0;t2:=9;dem:=1;
        vt1:=1;vt2:=9;
        repeat
                if (t<=t2) then exit;
                inc(dem);
                vt1:=vt1*10;vt2:=vt2*10+9;
                t1:=t2;t2:=(vt2-vt1+1)*dem+t2;
        until false;
end;

procedure process;
var     tmp1,tmp2:int64;
        tm:string;
begin
        tmp1:=vt1+(t-t1) div dem;
        tmp2:=(t-t1) mod dem;
        ans:='';
        if tmp2<>0 then
        begin
                str(tmp1,tm);
                ans:=copy(tm,1,tmp2);
        end;
        while (length(ans)<n) and (tmp1>1) do
        begin
                dec(tmp1);
                str(tmp1,tm);
                ans:=tm+ans;
        end;
        while length(ans)<n do ans:=' '+ans;
        ans:=copy(ans,length(ans)-n+1,n);
end;

procedure output;
begin
        write(go,ans);
        close(gi);close(go);
end;

begin
        input;
        find;
        process;
        output;
end.












