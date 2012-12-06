CREATE OR REPLACE FUNCTION restart_crashed_instance
(p_instance_id text)
RETURNS integer AS
$BODY$
DECLARE
  v_app app%rowtype;
BEGIN

  SELECT app.* FROM app
    JOIN instance ON app.id = instance.app_id
    WHERE instance.id = p_instance_id
    LIMIT 1 INTO v_app;

  IF (v_app.id IS NOT NULL) THEN
    PERFORM start_instance(v_app.id, p_instance_id);
  END IF;

  RETURN 1;

END;
$BODY$
LANGUAGE plpgsql VOLATILE
-- vim: set filetype=pgsql :

